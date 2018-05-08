// @flow
import * as React from 'react';
import * as ReactDOM from 'react-dom';
import Layout from './modules/Layout';
import ProjectsList from './views/ProjectsList';

ReactDOM.render(
  <Layout>
    <ProjectsList />
  </Layout>,
  ((document.querySelector('#app-root'): any): HTMLElement)
);
